import mongoose from "mongoose";

const UserSchema = new mongoose.Schema({
  name: { type: String, required: true, trim: true },
  email: { type: String, required: true, trim: true },
  phone: { type: String, required: true, trim: true },
  imagePath: { type: String, trim: true },
  address: { type: String, trim: true },
  latitude: { type: String, trim: true },
  longitude: { type: String, trim: true },
  role: { type: Number, required: true },
  password: { type: String, required: true, trim: true },
  gallery: [{ type: String, trim: true }],
});

const UserModel = new mongoose.model("user", UserSchema);

export default UserModel;
