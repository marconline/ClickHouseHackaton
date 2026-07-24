export default function TableWidget(
{
    title,
    columns,
    rows
}:any
){

    return (

        <div>

            <h3>
                {title}
            </h3>


            <table
                style={{
                    width:"100%",
                    borderCollapse:"collapse"
                }}
            >

                <thead>

                    <tr>

                        {
                            columns.map(
                                (c:string)=>
                                <th
                                    key={c}
                                    style={{
                                        textAlign:"left",
                                        borderBottom:"1px solid #ddd"
                                    }}
                                >
                                    {c}
                                </th>
                            )
                        }

                    </tr>

                </thead>


                <tbody>

                    {
                        rows.map(
                            (row:any,i:number)=>(

                                <tr key={i}>

                                    {
                                        columns.map(
                                            c=>
                                            <td
                                                key={c}
                                                style={{
                                                    padding:8
                                                }}
                                            >
                                                {row[c]}
                                            </td>
                                        )
                                    }

                                </tr>

                            )
                        )
                    }

                </tbody>


            </table>


        </div>

    );

}