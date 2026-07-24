export default function InsightWidget(
{
    title,
    text,
    severity="neutral"
}:any
){

    return (

        <div
            className="card"
            style={{
                borderLeft:
                    severity==="positive"
                    ? "5px solid #12b76a"
                    :
                    severity==="negative"
                    ? "5px solid #f04438"
                    :
                    "5px solid #98a2b3"
            }}
        >

            <h3>
                {title}
            </h3>


            <p>
                {text}
            </p>


        </div>

    );

}