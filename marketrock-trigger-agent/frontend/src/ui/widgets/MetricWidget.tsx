interface Props {

    label:string;

    value:number;

    unit?:string;

    currency?:string;

    trend:number;

    trendLabel?:string;

}



export default function MetricWidget(
{
    label,
    value,
    unit,
    currency,
    trend,
    trendLabel
}:Props
){

const positive =
    trend >= 0;


return (

<div className="card">


<div
style={{
    color:"#667085",
    fontSize:14
}}
>
    {label}
</div>


<div
style={{
    fontSize:32,
    fontWeight:700,
    marginTop:8
}}
>

{
    value.toLocaleString()
}

{
    currency &&
    ` ${currency}`
}

{
    unit &&
    ` ${unit}`
}

</div>


<div

style={{

    marginTop:12,

    color:
        positive
        ? "#12B76A"
        : "#F04438",

    fontWeight:600

}}

>

{
positive
? "▲"
: "▼"
}

{" "}

{
Math.abs(trend)
}%

{
trendLabel &&
` ${trendLabel}`
}

</div>


</div>

);

}