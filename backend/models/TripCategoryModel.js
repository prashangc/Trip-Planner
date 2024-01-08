import mongoose from "mongoose"

const TripCategorySchema = new mongoose.Schema({
    category: {type: String, required: true, trim: true},
    image: {type: String, required: true, trim: true},
    imagePath: {type: String, required: true, trim: true},
})

const TripCategoryModel = new mongoose.model('trip_category', TripCategorySchema)

export default TripCategoryModel