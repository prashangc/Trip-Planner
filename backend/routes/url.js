import express from "express"
import UserController from "../controllers/UserController.js"
import TripCategoryController from "../controllers/TripCategoryController.js"
import HotelController from "../controllers/HotelsController.js"
import ProfileController from "../controllers/ProfileController.js"
import checkUserAuth from '../middlewares/auth-middleware.js'
import ReviewsController from "../controllers/ReviewsController.js"
import FavouritesController from "../controllers/FavouritesController.js"
import BookingController from "../controllers/BookingController.js"

const router =  express.Router()

//Unauthorized routes
router.post('/register', UserController.registerUser)
router.post('/login', UserController.loginUser)
router.get('/category', TripCategoryController.getCategory)
router.get('/review/:id', ReviewsController.getHotelReviews)
router.get('/review', ReviewsController.getAllReviews)

// Authorized routes
router.get('/hotel', checkUserAuth, HotelController.getHotel)
router.get('/profile', checkUserAuth, ProfileController.getProfile)
router.post('/profile/update', checkUserAuth, ProfileController.updateProfile)
router.post('/room/add', checkUserAuth, HotelController.addRoom)
router.post('/room/update', checkUserAuth, HotelController.editRoom)
router.delete('/room/delete', checkUserAuth, HotelController.deleteRoom)
router.post('/service/add', checkUserAuth, HotelController.addService)
router.post('/service/update', checkUserAuth, HotelController.editService)
router.delete('/service/delete', checkUserAuth, HotelController.deleteService)
router.post('/favourites', checkUserAuth, FavouritesController.addHotelToFavourites)
router.delete('/favourites', checkUserAuth, FavouritesController.removeHotelFromFavourite)
router.get('/favourites', checkUserAuth, FavouritesController.getFavouriteHotel)
router.post('/review/add', checkUserAuth, ReviewsController.addReview)
router.get('/booking', checkUserAuth, BookingController.getBookedHotel)
router.post('/booking', checkUserAuth, BookingController.bookHotel)

export default router
