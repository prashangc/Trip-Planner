import mongoose from "mongoose";

const HotelSchema = new mongoose.Schema({
  profile: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "user",
    required: true,
  },
  room: [
    {
      room_number: { type: Number },
      price: { type: mongoose.Schema.Types.Decimal128 },
    },
  ],
  service: [
    {
      service_name: { type: String },
      price: { type: mongoose.Decimal128 },
      imagePath: { type: String, trim: true },
    },
  ],
});
const HotelModel = new mongoose.model("hotels", HotelSchema);

export default HotelModel;
