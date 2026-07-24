# Welcome!

It has been a long journey to get here!
Hope you like it and have fun at least as much as we had building it!

## Few info on the architecture

The app is composed by:
  - a web app, where the user can chat with the agent
  - an API layer which connects the web app to the Trigger.dev task
  - the Trigger.dev task which has in charge the orchestration between OpenAI API and ClickHouse

A ClickHouse server is a prerequisite for this all to work.

## Setup

Setup is simple. Just follow these steps.

### ClickHouse
- Create an .env in the root. You must add these values:
  - CLICKHOUSE_URL=[URL OF YOUR CLICKHOUSE SERVER]
  - CLICKHOUSE_USER=[CLICKHOUSE USERNAME]
  - CLICKHOUSE_PASSWORD=[CLICKHOUSE PASSWORD]
  - CLICKHOUSE_DATABASE=[CLICKHOUSE DATABASE, IF NOT EXISTING IT WILL BE CREATED]
  - TRIGGER_SECRET_KEY=[TRIGGER.DEV SECRET KEY]
  - OPENAI_API_KEY=[API KEY FOR OPEN AI]
  
- Launch npx tsx backend/import/initDatabase.ts, to:
  - create the database
  - create bronze, silver and gold tables
  - create materialized views
  - bulk import data

### Trigger.dev
- Just launch npx trigger.dev@latest dev

### Web App
- go into the /frontend-next folder
- launch npm run dev
- Web App will be running on http://localhost:5173/


## What to do next?

Just launch the Web App and start asking something!
