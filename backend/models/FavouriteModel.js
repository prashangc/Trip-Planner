import mongoose from "mongoose";

const FavouritesSchema = new mongoose.Schema({
  user_id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "user",
    required: true,
  },
  hotel: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "hotels",
    required: true,
  },
});

const FavouritesModel = new mongoose.model("favourites", FavouritesSchema);

export default FavouritesModel;
