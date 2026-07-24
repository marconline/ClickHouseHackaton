import {
    APIProvider,
    Map,
    AdvancedMarker
}
from "@vis.gl/react-google-maps";


interface Props {

    title:string;

    markers:{
        lat:number;
        lng:number;
        label:string;
        value:number;
    }[];

}



export default function MapWidget(
{
    title,
    markers
}:Props
){


return (

<div className="card">

<h3>
{title}
</h3>


<APIProvider
 apiKey={
   import.meta.env.VITE_GOOGLE_MAPS_KEY
 }
>


<Map

defaultCenter={{
    lat:42.5,
    lng:12.5
}}

defaultZoom={6}

style={{
    height:500
}}

>


{
markers.map(
(m,index)=>(

<AdvancedMarker

key={index}

position={{
    lat:m.lat,
    lng:m.lng
}}

>

<div

style={{

background:"#2563eb",

color:"white",

borderRadius:"50%",

width:
Math.min(
50,
20 + m.value/100
),

height:
Math.min(
50,
20 + m.value/100
),

display:"flex",

alignItems:"center",

justifyContent:"center"

}}

>

{m.value}

</div>


</AdvancedMarker>


)
)
}


</Map>


</APIProvider>


</div>

);

}