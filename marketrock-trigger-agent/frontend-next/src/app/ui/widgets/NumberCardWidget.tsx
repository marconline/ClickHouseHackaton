interface Props {

    label:string;

    value:number;

    unit?:string;

    currency?:string;

}



export default function NumberCardWidget(
{
    label,
    value,
    unit,
    currency
}:Props
){


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

    fontSize:36,

    fontWeight:700,

    marginTop:10

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


</div>

);

}