import TripCategoryModel from "../models/TripCategoryModel.js";

class TripCategoryController {
  static getCategory = async (req, res) => {
    try {
      const result = await TripCategoryModel.find();
      res.send(result);
    } catch (e) {
      console.log("error while getting trip category api");
    }
  };
}

export default TripCategoryController
