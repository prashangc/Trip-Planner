import mongoose from "mongoose";

const BookingSchema = new mongoose.Schema({
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
  room: {
    room_number: { type: Number },
    price: { type: mongoose.Schema.Types.Decimal128 },
  },
  status: { type: Number, required: true }, // 0 (booking waiting for approval - Pending)  , 1 (booking accepted - Booked) ,2 (booking rejected- Rejected), 3 (Cancelled by user - Canceled), 4 (Completed)
});

const BookingModel = new mongoose.model("booking", BookingSchema);

export default BookingModel;
