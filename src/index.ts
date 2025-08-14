
// Import needed built in and external libraries.
import { Handler } from 'aws-lambda';
import { default as axios } from 'axios';


export const handler: Handler = async (event,context) => {

    console.log("## Context: " + JSON.stringify(context));
    console.log("## Event: " + JSON.stringify(event));

    try {
        let req_url = `https://ticketflow.ngrok.io/rest/ticket/${event.ticket_number}`;
        let req_method = 'GET';
       

        let request = {
            method: req_method,
            url: req_url
        };

        const response = await axios.request(request);
        return {
            ticket_number: response.data.ticket_number,
            status: response.data.status,
            priority: response.data.priority,
            changed: response.data.changed,
            notes: response.data.notes
        }

      
    } catch (e) {
        //Example of using the callback to return an error
        console.error("Handler failed: " + e);
        throw e;
    }
    
};


