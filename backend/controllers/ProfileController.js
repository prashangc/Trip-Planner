import UserModel from "../models/UserModel.js";

class ProfileController {
  static getProfile = async (req, res) => {
    try {
      const userProfile = await UserModel.findById(req.user._id).select(
        "-password -__v"
      );
      res.status(200).send(userProfile);
    } catch (e) {
      console.log(e);
      res.status(500).send({ status: "failed", message: "Server is busy" });
    }
  };

  static updateProfile = async (req, res) => {
    try {
      const { name, address, latitude, longitude, gallery } = req.body;
      if (
        name == null &&
        address == null &&
        latitude == null &&
        longitude == null &&
        gallery == null
      ) {
      res.status(401).send({ status: "failed", message: "No any changes" });

      } else {
        const update = {
          $set: {
            name: name,
            address: address,
            latitude: latitude,
            longitude: longitude,
            gallery: gallery,
          },
        };
        await UserModel.updateOne({ _id: req.user._id }, update);
        const userProfile = await UserModel.find(req.user._id).select(
          "-password -__v"
        );
        res
          .status(200)
          .send({
            status: "success",
            message: "Profile Updated",
            profile: userProfile,
          });
      }
    } catch (e) {
      console.log(e);
      res.status(500).send({ status: "failed", message: "Server is busy" });
    }
  };
}

export default ProfileController;
