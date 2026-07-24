import "dotenv/config";

import fs from "fs/promises";
import path from "path";

import { executeQuery, executeQueryDefault } from "../tools/analytics.js";
import { loadData } from "./loadAll.js";
import { buildAnalytics } from "./buildAnalytics.js";

const folders = [
    "bronze",
    "silver",
    "gold",
    "materialized_views"
];


async function executeFolder(folder: string) {

    const folderPath = path.resolve(
        `./backend/import/sql/${folder}`
    );

    const files = (
        await fs.readdir(folderPath)
    )
    .filter(x => x.endsWith(".sql"))
    .sort();


    for (const file of files) {

        const fullPath = path.join(
            folderPath,
            file
        );

        console.log(
            `▶ ${folder}/${file}`
        );


        const sql = await fs.readFile(
            fullPath,
            "utf8"
        );


        if (!sql.trim()) {
            continue;
        }


        await executeQuery(sql);


        console.log(
            `✓ ${file}`
        );
    }
}


async function main() {


    console.log(
        `🚀 Initializing ClickHouse ${process.env.CLICKHOUSE_DATABASE}`
    );


    await executeQueryDefault(`
        CREATE DATABASE IF NOT EXISTS ${process.env.CLICKHOUSE_DATABASE}
    `);


    for (const folder of folders) {
        await executeFolder(folder);
    }


    console.log(
        "✅ Database initialized"
    );

    await loadData();

    console.log(
        "✅ Data loaded"
    );

    await buildAnalytics();

    console.log(
        "✅ Analytics built"
    );
}


main()
.catch(err => {

    console.error(err);

    process.exit(1);

});