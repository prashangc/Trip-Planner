import mongoose from "mongoose";

const ReviewSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "user",
    required: true,
  },
  hotel: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "hotels",
    required: true,
  },
  rating: { type: Number, required: true },
  review: { type: String, required: true, trim: true },
});

const ReviewModel = new mongoose.model("reviews", ReviewSchema);

export default ReviewModel;
