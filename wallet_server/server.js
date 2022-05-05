var http = require('http'); // Import Node.js core module
var Web3 = require('web3');
import {getWeb3} from './utils.js';



var server = http.createServer(function (req, res) {   //create web server
    if (req.url == '/') { //check the URL of the current request
        
        // set response header
        res.writeHead(200, { 'Content-Type': 'text/html' }); 
        
        // set response content    
        res.write('<html><body><p>This is home Page.</p></body></html>');
        res.end();
    
    }
    else
        res.end('Invalid Request!');

    var web3 = getWeb3();
    web3.eth.getBalance("0xBAc049334F5884F0e7675339D551585464a6B798", function(err, result) {
        if (err) {
          console.log(err)
        } else {
          console.log(web3.utils.fromWei(result, "ether") + " ETH")
        }
      });

});



server.listen(5001); //6 - listen for any incoming requests

console.log('Node.js web server at port 5001 is running..')