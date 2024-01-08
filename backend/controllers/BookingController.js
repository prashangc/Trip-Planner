import BookingModel from "../models/BookingModel.js";
import HotelModel from "../models/HotelModel.js";

class BookingController {
  static getBookedHotel = async (req, res) => {
    try {
      const booking = await BookingModel.find({
        user_id: req.user._id,
      })
        .populate({
          path: "hotel",
          select: "-password",
          populate: {
            path: "profile",
          },
        })
        .exec();
      res.send(booking);
    } catch (e) {
      console.log(e);
      res.status(500).send({
        status: "failed",
        message: "Server is busy, Couldn't book hotel !!!",
      });
    }
  };

  static bookHotel = async (req, res) => {
    try {
      const { hotel_id, room_id } = req.body;
      const emptyFields = Object.entries({
        hotel_id,
        room_id,
      })
        .filter(([key, value]) => !value)
        .map(([key]) => key);
      if (emptyFields.length == 0) {
        const hotel = await HotelModel.findOne({
          _id: hotel_id,
        })
          .populate({
            path: "profile",
            select: "-password",
          })
          .exec();
        const room = hotel.room.find((room) => room._id.toString() === room_id);
        const bookingDoc = new BookingModel({
          user_id: req.user,
          hotel: hotel,
          room: room,
          status: 0,
        });
        await bookingDoc.save();
        res.send({
          status: "success",
          message: "Hotel successfully booked.",
        });
      } else {
        res.status(400).send({
          status: "failed",
          message: `Please enter your ${emptyFields[0]}.`,
        });
      }
    } catch (e) {
      console.log(e);
      res.status(500).send({
        status: "failed",
        message: "Server is busy, Couldn't find booked hotel !!!",
      });
    }
  };
}

export default BookingController;
