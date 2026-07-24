export interface AnalyticsRequest {

    from: string;

    to: string;

    /**
     * Optional ISO currency code
     * Example: EUR, USD
     */
    currency?: string;

}

export type ToolResult<T = any> = {

    data:T;

    metadata?: {

        title?:string;

        description?:string;

        currency?:string;

        generatedAt?:string;

    };

};