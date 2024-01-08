import HotelModel from "../models/HotelModel.js";
import ReviewModel from "../models/ReviewModel.js";
import UserModel from "../models/UserModel.js";

class ReviewsController {
  static addReview = async (req, res) => {
    try {
      const { hotel_id, rating, review } = req.body;
      const emptyFields = Object.entries({
        hotel_id,
        rating,
        review,
      })
        .filter(([key, value]) => !value)
        .map(([key]) => key);
      if (emptyFields.length == 0) {
        const hotel = await HotelModel.findOne({
          _id: hotel_id,
        });
        const userProfile = await UserModel.findById(req.user._id).select(
          "-password -__v"
        );
        if (hotel) {
          const reviewDoc = new ReviewModel({
            user: userProfile,
            hotel: hotel,
            rating: rating,
            review: review,
          });
          await reviewDoc.save();
          res.send({
            status: "success",
            message: "Review added successfully.",
          });
        } else {
          res.status(400).send({
            status: "failed",
            message: "Hotel not found !!!",
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
      res.status(500).send({
        status: "failed",
        message: "Server is busy, Couldn't add review about hotel !!!",
      });
    }
  };

  static getHotelReviews = async (req, res) => {
    try {
      const reviews = await ReviewModel.find({
        hotel: req.params.id,
      })
        .populate({
          path: "user",
          select: "-password",
        })
        .exec();
      res.send(reviews);
    } catch (e) {
      console.log(e);
      res.status(500).send({
        status: "failed",
        message: "Server is busy, Couldn't find reviews !!!",
      });
    }
  };

  static getAllReviews = async (req, res) => {
    try {
      const reviews = await ReviewModel.find().populate('user', '-password -__v');
      res.send(reviews);
    } catch (e) {
      console.log(e);
      res.status(500).send({
        status: "failed",
        message: "Server is busy, Couldn't find reviews !!!",
      });
    }
  };
}
export default ReviewsController;
