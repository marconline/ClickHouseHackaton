export default function Header(){

return (

<header
style={{
display:"flex",
alignItems:"center",
justifyContent:"space-between",
padding:"20px 40px",
background:"white",
borderBottom:"1px solid #eee"
}}
>


<img
src="/marketrock-logo.svg"
style={{
height:42
}}
/>


<div
style={{
fontWeight:600,
fontSize:20
}}
>
AI Analytics Agent
</div>


</header>

);

}