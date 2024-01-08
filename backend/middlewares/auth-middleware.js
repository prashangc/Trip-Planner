import jwt from "jsonwebtoken"
import UserModel from "../models/UserModel.js"

var checkUserAuth = async (req, res, next) => {
    let token
    const {authorization} = req.headers
    try{
        if(authorization && authorization.startsWith('Bearer')){
            token = authorization.split(' ')[1]
            // verify token 
            const { userID }  = jwt.verify(token, process.env.JWT_SECRET_KEY)
            //get user from token
            req.user = await UserModel.findById(userID)
            next()
          }else{
             res.status(401).send({"status": "failed", "message": "Unauthorized user"})
        }
    }catch(e){
        console.log(e)
        res.status(401).send({"status": "failed", "message": "Unauthorized user"})
    }
}

export default checkUserAuth