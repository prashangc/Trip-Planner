import HotelModel from "../models/HotelModel.js";
import UserModel from "../models/UserModel.js";

class HotelController {
  static getHotel = async (req, res) => {
    try {
      if (req.user.role == 3) {
        const result = await HotelModel.findOne()
          .populate({
            path: "profile",
            select: "-password",
            match: { email: req.user.email, role: req.user.role },
          })
          .exec();
        res.send([result]);
      } else {
        const result = await HotelModel.find()
          .populate({
            path: "profile",
            select: "-password",
          })
          .exec();
        res.send(result);
      }
    } catch (e) {
      console.log(e);
      res.status(500).send({ status: "failed", message: "Server is busy" });
    }
  };

  static addRoom = async (req, res) => {
    try {
      const { room_no, price } = req.body;
      const emptyFields = Object.entries({
        room_no,
        price,
      })
        .filter(([key, value]) => !value)
        .map(([key]) => key);
      if (emptyFields.length == 0) {
        const hotel = await HotelModel.findOne()
        .populate({
          path: "profile",
          select: "-password",
          match: { email: req.user.email },
        })
        .exec();
        if (hotel) {
          hotel.room.push({ room_number: room_no, price: price });
          await hotel.save();
          res.send({
            status: "success",
            message: "Room added.",
          });
        } else {
          res.status(400).send({
            status: "error",
            message: "No any hotel founds.",
          });
        }
      } else {
        res.status(400).send({
          status: "failed",
          message: `Please enter your ${emptyFields[0]}.`,
        });
      }
    } catch (e) {
      console.log(e);
      res.status(500).send({ status: "failed", message: "Server is busy" });
    }
  };

  static addService = async (req, res) => {
    try {
      const { service_name, price } = req.body;

      const emptyFields = Object.entries({
        service_name,
        price,
      })
        .filter(([key, value]) => !value)
        .map(([key]) => key);
      if (emptyFields.length == 0) {
        const hotel = await HotelModel.findOne()
          .populate({
            path: "profile",
            select: "-password",
            match: { email: req.user.email },
          })
          .exec();
        if (hotel) {
          hotel.service.push({ service_name: service_name, price: price });
          await hotel.save();
          res.send({
            status: "success",
            message: "Service added.",
          });
        } else {
          res.status(400).send({
            status: "error",
            message: "No any hotel founds.",
          });
        }
      } else {
        res.status(400).send({
          status: "failed",
          message: `Please enter your ${emptyFields[0]}.`,
        });
      }
    } catch (e) {
      console.log(e);
      res.status(500).send({ status: "failed", message: "Server is busy" });
    }
  };

  static editRoom = async (req, res) => {
    try {
      const { room_id, room_no, price } = req.body;
      if (room_id != null) {
        const hotel = await HotelModel.findOne()
          .populate({
            path: "profile",
            select: "-password",
            match: { email: req.user.email },
          })
          .exec();
        const rooms = hotel.room.find((r) => r._id.toString() === room_id);
        if (rooms) {
          await HotelModel.findOneAndUpdate(
            { "room._id": room_id },
            {
              $set: {
                "room.$.room_number": room_no,
                "room.$.price": price,
              },
            },
            { new: true }
          ).populate({
            path: "profile",
            select: "-password",
            match: { email: req.user.email },
          });
          res.send({
            status: "success",
            message: "Room Updated.",
          });
        } else {
          res.status(400).send({
            status: "failed",
            message: "No room of this ID found.",
          });
        }
      } else {
        res.status(400).send({
          status: "failed",
          message: "Please enter the room id.",
        });
      }
    } catch (e) {
      console.log(e);
      res.status(500).send({ status: "failed", message: "Server is busy" });
    }
  };

  static deleteRoom = async (req, res) => {
    try {
      const { room_id } = req.body;
      const hotel = await HotelModel.findOne()
        .populate({
          path: "profile",
          select: "-password",
          match: { email: req.user.email },
        })
        .exec();
      const rooms = hotel.room.find((r) => r._id.toString() === room_id);
      if (rooms) {
        await HotelModel.findOneAndUpdate(
          { "room._id": room_id },
          { $pull: { room: { _id: room_id } } },
          { new: true }
        ).populate({
          path: "profile",
          select: "-password",
          match: { email: req.user.email },
        });
        res.send({
          status: "success",
          message: "Room Deleted.",
        });
      } else {
        res.status(400).send({
          status: "failed",
          message: "No room of this ID found.",
        });
      }
    } catch (e) {
      console.log(e);
      res.status(500).send({ status: "failed", message: "Server is busy" });
    }
  };

  static editService = async (req, res) => {
    try {
      const { service_id, service_name, price } = req.body;
      if (service_id != null) {
        const hotel = await HotelModel.findOne()
          .populate({
            path: "profile",
            select: "-password",
            match: { email: req.user.email },
          })
          .exec();
        const services = hotel.service.find(
          (r) => r._id.toString() === service_id
        );
        if (services) {
          await HotelModel.findOneAndUpdate(
            { "service._id": service_id },
            {
              $set: {
                "service.$.service_name": service_name,
                "service.$.price": price,
              },
            },
            { new: true }
          ).populate({
            path: "profile",
            select: "-password",
            match: { email: req.user.email },
          });
          res.send({
            status: "success",
            message: "Service Updated.",
          });
        } else {
          res.status(400).send({
            status: "failed",
            message: "No service of this ID found.",
          });
        }
      } else {
        res.status(400).send({
          status: "failed",
          message: "Please enter the service id.",
        });
      }
    } catch (e) {
      console.log(e);
      res.status(500).send({ status: "failed", message: "Server is busy" });
    }
  };

  static deleteService = async (req, res) => {
    try {
      const { service_id } = req.body;
      if (service_id != null) {
        const hotel = await HotelModel.findOne()
          .populate({
            path: "profile",
            select: "-password",
            match: { email: req.user.email },
          })
          .exec();
        const services = hotel.service.find(
          (r) => r._id.toString() === service_id
        );
        if (services) {
          await HotelModel.findOneAndUpdate(
            { "service._id": service_id },
            { $pull: { service: { _id: service_id } } },
            { new: true }
          ).populate({
            path: "profile",
            select: "-password",
            match: { email: req.user.email },
          });
          res.send({
            status: "success",
            message: "Service Deleted.",
          });
        } else {
          res.status(400).send({
            status: "failed",
            message: "No service of this ID found.",
          });
        }
      } else {
        res.status(400).send({
          status: "failed",
          message: "Please enter the service id.",
        });
      }
    } catch (e) {
      console.log(e);
      res.status(500).send({ status: "failed", message: "Server is busy" });
    }
  };
}

export default HotelController;
