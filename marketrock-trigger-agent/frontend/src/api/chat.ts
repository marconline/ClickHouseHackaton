import axios from "axios";


export async function ask(
    conversationId:string,
    question:string
){

    const response =
        await axios.post(
            "http://localhost:3001/chat",
            {
                question
            }
        );


    return response.data;

}