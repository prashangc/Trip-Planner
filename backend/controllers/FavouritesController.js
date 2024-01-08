import FavouritesModel from "../models/FavouriteModel.js";
import HotelModel from "../models/HotelModel.js";
import UserModel from "../models/UserModel.js";

class FavouritesController {
  static addHotelToFavourites = async (req, res) => {
    try {
      const { hotel_id } = req.body;
      if (hotel_id) {
        const favouriteHotel = await FavouritesModel.findOne({
          user_id: req.user._id,
          hotel: hotel_id,
        });
        if (favouriteHotel) {
          res.status(400).send({
            status: "failed",
            message: "Hotel already added to favourites.",
          });
        } else {
          const hotel = await HotelModel.findById(hotel_id)
            .populate({
              path: "profile",
              select: "-password",
            })
            .exec();
          const favDoc = new FavouritesModel({
            user_id: req.user,
            hotel: hotel,
          });
          await favDoc.save();
          res.send({
            status: "success",
            message: "Hotel added to favourites.",
          });
        }
      } else {
        res.status(400).send({
          status: "failed",
          message: "Hotel ID not found !!!",
        });
      }
    } catch (e) {
      console.log(e);
      res.status(500).send({
        status: "failed",
        message: "Server is busy, Couldn't add hotel to favourites !!!",
      });
    }
  };

  static getFavouriteHotel = async (req, res) => {
    try {
      const favouriteHotel = await FavouritesModel.find({
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
      res.send(favouriteHotel);
    } catch (e) {
      console.log(e);
      res.status(500).send({
        status: "failed",
        message: "Server is busy, Couldn't find favourites hotels !!!",
      });
    }
  };

  static removeHotelFromFavourite = async (req, res) => {
    try {
      const { hotel_id } = req.body;
      if (hotel_id) {
        const favouriteHotel = await FavouritesModel.findOneAndDelete({
          user_id: req.user._id,
          hotel: hotel_id,
        });
        if (favouriteHotel) {
          res.send({
            status: "success",
            message: "Hotel removed from favorites successfully.",
          });
        } else {
          console.log(e);
          res.status(400).send({
            status: "failed",
            message: "No Hotel of this ID found !!!",
          });
        }
      } else {
        res.status(400).send({
          status: "failed",
          message: "ID not found !!!",
        });
      }
    } catch (e) {
      console.log(e);
      res.status(500).send({
        status: "failed",
        message: "Server is busy, Couldn't delete hotel from favourites !!!",
      });
    }
  };
}

export default FavouritesController;
