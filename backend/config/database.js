import mongoose from "mongoose"

const connectDB = async (DATABASE_URL) =>{
    try{
        const DATABASE_OPTIONS = {
            dbName: 'trip-planner',
            authSource: 'trip-planner'
        }
        await mongoose.connect(DATABASE_URL, DATABASE_OPTIONS).then(()=>{
        console.log('Connected to database')

        })
    }catch(e){
        console.log(`Error connecting to database : ${e}`)
    }
} 

export default connectDB