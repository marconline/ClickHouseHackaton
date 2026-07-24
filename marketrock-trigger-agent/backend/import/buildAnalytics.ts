import "dotenv/config";

import fs from "fs/promises";
import path from "path";

import { executeQuery } from "../tools/analytics.js";


const sqlFolder = path.resolve("./backend/import/sql/import");


const scripts = [
    // silver
    "silver_order_line.sql",
    "silver_order.sql",
    "silver_shipping.sql",
    "silver_shipping_order.sql",
    "silver_shipping_status_history.sql",
    "silver_item.sql",
    "silver_item_identifier.sql",

    // gold
    "gold_order_fulfillment.sql",
    "gold_fact_sale.sql",
    "gold_shipping_delivery.sql"
];


export async function buildAnalytics() {

    for (const script of scripts) {

        const file = path.join(sqlFolder, script);

        console.log(`\n▶ Executing ${script}`);

        const sql = await fs.readFile(
            file,
            "utf8"
        );

        if (!sql.trim()) {
            console.log("  skipped (empty)");
            continue;
        }


        try {

            await executeQuery(sql);

            console.log(`✓ ${script} completed`);

        } catch (err) {

            console.error(
                `✗ ${script} failed`
            );

            throw err;
        }
    }


    console.log("\n✅ Analytics build completed");
}