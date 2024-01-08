import UserModel from "../models/UserModel.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import HotelModel from "../models/HotelModel.js";

class UserController {
  // roles:
  //  admin = 1
  //  user = 2
  //  hotel = 3
  static registerUser = async (req, res) => {
    const { name, email, phone, password, password_confirmation, role } =
      req.body;
    const emptyFields = Object.entries({
      name,
      email,
      phone,
      role,
      password,
      password_confirmation,
    })
      .filter(([key, value]) => !value)
      .map(([key]) => key);
    const userEmail = await UserModel.findOne({ email: email });
    const phoneNumber = await UserModel.findOne({ phone: phone });
    if (emptyFields.length == 0) {
      if (userEmail) {
        res
          .status(400)
          .send({ status: "failed", message: "Email already exists." });
      } else if (phoneNumber) {
        res
          .status(400)
          .send({ status: "failed", message: "Phone number already exists." });
      } else {
        if (password === password_confirmation) {
          try {
            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(password, salt);
            const doc = new UserModel({
              name: name,
              email: email,
              phone: phone,
              role: role,
              address: null,
              latitude: null,
              longitude: null,
              password: hashedPassword,
            });
            if (role == 3) {
              const hotelDoc = new HotelModel({
                profile: doc,
                room: [],
                service: [],
              });
              await hotelDoc.save();
            }

            await doc.save();

            const savedUser = await UserModel.findOne({ email: email });
            // Generate jwt token
            const token = jwt.sign(
              { userID: savedUser._id },
              process.env.JWT_SECRET_KEY,
              { expiresIn: "5d" }
            );
            res.send({
              status: "success",
              message: "registration success",
              token: token,
            });
          } catch (e) {
            res.status(500).send({
              status: "failed",
              message: `Something went wrong: ${e}`,
            });
          }
        } else {
          res
            .status(400)
            .send({ status: "failed", message: "Passwords doesn't match" });
        }
      }
    } else {
      res.status(400).send({
        status: "failed",
        message: `Please enter your ${emptyFields[0]}.`,
      });
    }
  };

  static loginUser = async (req, res) => {
    const { email, password, platform } = req.body;
    const emptyFields = Object.entries({
      email,
      password,
    })
      .filter(([key, value]) => !value)
      .map(([key]) => key);
    try {
      if (emptyFields.length == 0) {
        const user = await UserModel.findOne({ email: email });
        if (user) {
          const isMatch = await bcrypt.compare(password, user.password);
          if (user.email == email && isMatch) {
            if (user.role == 1 && platform == "mobile") {
              res
                .status(401)
                .send({ status: "failed", message: "Please use admin panel." });
            } else if (user.role == 3 && platform == "mobile") {
              res.status(401).send({
                status: "failed",
                message: "Please use hotel dashboard.",
              });
            } else if (user.role == 2 && platform == "web") {
              res.status(401).send({
                status: "failed",
                message: "Please use the mobile app.",
              });
            } else {
              // Generate jwt token
              const token = jwt.sign(
                { userID: user._id },
                process.env.JWT_SECRET_KEY,
                { expiresIn: "5d" }
              );
              const userProfile = await UserModel.findOne({email: email}).select('-password -__v')
              res.send({
                status: "success",
                message: "Login Successful",
                role: user.role,
                token: token,
                profile: userProfile
              });
            }
          } else {
            res
              .status(401)
              .send({ status: "failed", message: "Invalid Credentials" });
          }
        } else {
          res
            .status(401)
            .send({ status: "failed", message: "Email doesn't exist" });
        }
      } else {
        res.status(401).send({
          status: "failed",
          message: `Please enter your ${emptyFields[0]}`,
        });
      }
    } catch (e) {
      console.log(e);
      res
        .status(500)
        .send({ status: "failed", message: "Something went wrong" });
    }
  };

  // static getProfile = async (req, res) => {
  //   try {
  //     const sanitizedUser = { ...req.user.toObject(), password: undefined };
  //     res.send(req.user);
  //   } catch (e) {
  //     console.log(e);
  //     res
  //       .status(500)
  //       .send({ status: "failed", message: "Something went wrong" });
  //   }
  // };
}

export default UserController;
