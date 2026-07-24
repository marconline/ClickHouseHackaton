const conversations =
    new Map<string, any[]>();


export function getConversation(
    id:string
){

    if(!conversations.has(id))
    {
        conversations.set(
            id,
            []
        );
    }


    return conversations.get(id)!;

}



export function saveConversation(
    id:string,
    messages:any[]
){

    conversations.set(
        id,
        messages
    );

}