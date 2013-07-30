var http = require('http');

var tasks, numberOfTasks;

process.stdin.resume();
process.stdin.setEncoding('utf8');

process.stdin.on('data', function(input) {
  tasks = input.split("\n").filter(function(n){return n});
  console.log(tasks + "\n");
  numberOfTasks = tasks.length;
});

var counter = 0;

process.stdin.on('end', function() {
  console.log("Finish reading data\n");
  process.stdin.pause();

  var exit_status = 0;

  var server = http.createServer()
  server.listen(1337, 'localhost');
  server.setTimeout(50);

  server.on("request", function (req, res) {
    console.log(req.url);

    switch(req.url) {

      case '/scenario':
        incrementCounterAndRespond(res, tasks.shift() );
        break;

      case '/passed':
        analysePostData(req);
        incrementCounterAndRespond(res, "Ok");
        break;

      case '/failed':
        analysePostData(req);
        exit_status = 1;
        incrementCounterAndRespond(res, "Aww");
        break;

      default:
        res.end(); 
        break;
    }

    killProcessWhenAllFinish(server, exit_status);
  });


  console.log('Server running at http://127.0.0.1:1337/');

  });

var qs = require('querystring');
function analysePostData (request) {
   var data = '';
   request.on("data", function(input) {
     data += input;
   });

   request.on("end", function() {
     var params = qs.parse(data);
     recordResult( params['task'] , params['output'] );
   });
}

var failedResults = {};
function recordResult (taskDesc, output ) {
  failedResults[ taskDesc ] = output;
}

function incrementCounterAndRespond(res, responseText) {
  counter++;
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end(responseText);
}

function killProcessWhenAllFinish(server, exit_status) {
  if( counter > numberOfTasks*2 ) {
    outputFailedTasks();
    outputStatistic();
    server.close( function () {
      process.exit(exit_status);
    });
  }
}

function outputFailedTasks() {
  for( var taskDesc in failedResults) {
    console.log( failedResults[taskDesc] + "\n" );
  }
}

function outputStatistic() {
  var failedTasks = Object.keys(failedResults).length
  var passedTasks = numberOfTasks - failedTasks;
  console.log( "*************************************" );
  console.log( "Total tasks ran: " + numberOfTasks );
  console.log( passedTasks + " Passed" );
  console.log( failedTasks + " Failed" );
  console.log( "*************************************" );
}
