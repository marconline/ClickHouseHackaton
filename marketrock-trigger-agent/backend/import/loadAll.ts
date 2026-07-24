import "dotenv/config";
import fs from "fs";
import { clickhouse } from "../clickhouse/client.js";
import { tables } from "./tables.js";


export async function loadData() {

  for (const item of tables) {

    console.log(`START ${item.file}`);

    try {

        await clickhouse.insert({
            table: item.table,
            values: fs.createReadStream(`./backend/import/data/${item.file}`),
            format: "TabSeparated",
        });

        console.log(`DONE ${item.file}`);

    } catch (e) {
        console.error(`FAILED ${item.file}`, e);
    }
}
}
