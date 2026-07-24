import "dotenv/config";

import { getRevenueTrend } from "./tools/revenue.js";

async function main() {

    const result = await getRevenueTrend({

        from: "2026-01-01 00:00:00",

        to: "2026-12-31 23:59:59"

    });

    console.table(result);

}

main().catch(console.error);