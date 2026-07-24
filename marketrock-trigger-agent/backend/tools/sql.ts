import fs from "fs/promises";
import path from "path";


export async function loadSql(file: string) {

    return await fs.readFile(
        path.resolve(
            "./src/sql/tools",
            file
        ),
        "utf8"
    );

}