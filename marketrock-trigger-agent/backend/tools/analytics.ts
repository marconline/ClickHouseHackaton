import { clickhouse, clickhouseDefault } from "../clickhouse/client.js";


export async function executeQuery(
    sql:string,
    params?:Record<string,any>
){

    const result =
        await clickhouse.query({

            query:sql,

            query_params:params,

            format:"JSONEachRow"

        });


    const text =
        await result.text();


    if(!text.trim())
        return [];


    return text
        .trim()
        .split("\n")
        .map(line=>JSON.parse(line));

}

export async function executeQueryDefault(
    sql:string,
    params?:Record<string,any>
){
    const result =
        await clickhouseDefault.query({

            query:sql,

            query_params:params,

            format:"JSONEachRow"

        });


    const text =
        await result.text();


    if(!text.trim())
        return [];


    return text
        .trim()
        .split("\n")
        .map(line=>JSON.parse(line));
}