var http = require('http');

var tasks, numberOfTasks;

process.stdin.resume();
process.stdin.setEncoding('utf8');

process.stdin.on('data', function(input) {
  tasks = input.split("\n"); 
  numberOfTasks = tasks.length;
});

var counter = 0;

process.stdin.on('end', function() {
  console.log("Finish reading data\n");
  console.log("data is :" + tasks);
  process.stdin.pause();

  var exit_status = 0;

  var server = http.createServer()
  server.listen(1337, 'localhost');
  server.setTimeout(50);

  server.on("request", function (req, res) {
    console.log(req.url);

    switch(req.url) {
      case '/feature':
        console.log(  );
        incrementCounterAndRespond(res, tasks.shift() );
        break;
      case '/passed':
        incrementCounterAndRespond(res, "ok");
        break;
      case '/failed':
        exit_status = 1;
        incrementCounterAndRespond(res, "aww");
        break;
      default:
        res.end(); 
        break;
    }

    killProcessWhenAllFinish(exit_status);
  });


  console.log('Server running at http://127.0.0.1:1337/');

  });

function incrementCounterAndRespond(res, responseText) {
  counter++;
  console.log(counter);
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end(responseText + "\n" + counter + "\n");
}

function killProcessWhenAllFinish(exit_status) {
  if( counter == numberOfTasks-1 ) {
    console.log( "closing server");
    process.exit(exit_status);
  }
}


