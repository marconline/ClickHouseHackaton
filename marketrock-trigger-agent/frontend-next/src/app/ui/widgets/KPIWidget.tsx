export default function KPIWidget({
items=[]
}:any){

return (

<div
style={{
display:"grid",
gridTemplateColumns:"repeat(auto-fit,minmax(220px,1fr))",
gap:20
}}
>


{
items.map(
(item:any,index:number)=>(

<div
className="card"
key={index}
>


<div
style={{
fontSize:14,
color:"#667085"
}}
>
{item.label}
</div>


<div
style={{
fontSize:32,
fontWeight:700,
marginTop:8,
color:"#101828"
}}
>

{item.value.toLocaleString()}

{
item.currency &&
<span
style={{
fontSize:16,
marginLeft:5
}}
>
{item.currency}
</span>
}

</div>


</div>

))
}


</div>

)

}