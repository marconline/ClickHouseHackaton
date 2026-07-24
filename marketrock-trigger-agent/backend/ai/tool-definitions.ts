export const toolDefinitions = [

{
    type:"function",
    function:{
        name:"getSalesOverview",

        description:
        "Restituisce KPI generali di vendita: fatturato, ordini, quantità per periodo.",

        parameters:{
            type:"object",
            properties:{
                from:{
                    type:"string",
                    description:"Data iniziale YYYY-MM-DD"
                },
                to:{
                    type:"string",
                    description:"Data finale YYYY-MM-DD"
                },
                currency:{
                    type:"string",
                    description:"Valuta opzionale"
                }
            },
            required:[
                "from",
                "to"
            ]
        }
    }
},


{
    type:"function",
    function:{
        name:"getRevenueTrend",

        description:
        "Restituisce l'andamento del fatturato nel tempo.",

        parameters:{
            type:"object",
            properties:{
                from:{
                    type:"string"
                },
                to:{
                    type:"string"
                }
            },
            required:[
                "from",
                "to"
            ]
        }
    }
},


{
    type:"function",
    function:{
        name:"getTopProducts",

        description:
        "Restituisce i prodotti con maggiore fatturato o quantità venduta.",

        parameters:{
            type:"object",
            properties:{
                from:{
                    type:"string"
                },
                to:{
                    type:"string"
                },
                limit:{
                    type:"number"
                }
            },
            required:[
                "from",
                "to"
            ]
        }
    }
},


{
    type:"function",
    function:{
        name:"getMarketplacePerformance",

        description:
        "Analizza performance dei marketplace.",

        parameters:{
            type:"object",
            properties:{
                from:{
                    type:"string"
                },
                to:{
                    type:"string"
                }
            },
            required:[
                "from",
                "to"
            ]
        }
    }
},


{
    type:"function",
    function:{
        name:"getFulfillmentOverview",

        description:
        "Analizza spedizioni, consegne e fulfillment.",

        parameters:{
            type:"object",
            properties:{
                from:{
                    type:"string"
                },
                to:{
                    type:"string"
                }
            },
            required:[
                "from",
                "to"
            ]
        }
    }
},


{
    type:"function",
    function:{
        name:"getMarketplaceFulfillmentPerformance",

        description:
        "Confronta le performance di fulfillment tra marketplace.",

        parameters:{
            type:"object",
            properties:{
                from:{
                    type:"string"
                },
                to:{
                    type:"string"
                }
            },
            required:[
                "from",
                "to"
            ]
        }
    }
},


{
    type:"function",
    function:{
        name:"getCustomerHealthSummary",

        description:
        "Restituisce indicatori sulla salute dei clienti.",

        parameters:{
            type:"object",
            properties:{
                from:{
                    type:"string"
                },
                to:{
                    type:"string"
                }
            },
            required:[
                "from",
                "to"
            ]
        }
    }
}

];