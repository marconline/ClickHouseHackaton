export type ChatMessage =
{
    role:"user"|"assistant";

    content:string;

    response?:any;
};