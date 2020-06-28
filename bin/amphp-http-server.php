<?php
require __DIR__ . '/../vendor/autoload.php';

use Amp\Http\Server\RequestHandler\CallableRequestHandler;
use Amp\Http\Server\HttpServer;
use Amp\Http\Server\Request;
use Amp\Http\Server\Response;
use Amp\Http\Status;
use Amp\Socket\Server;
use Psr\Log\NullLogger;

Amp\Loop::run(function () {
    $sockets = [
        Server::listen(
            "0.0.0.0:8888",
            (new \Amp\Socket\BindContext())
                 ->withBacklog(50000)
        ),
    ];

    $counter = 0;

    $options = (new \Amp\Http\Server\Options())
        ->withoutCompression()
        ->withConnectionsPerIpLimit(100000)
        ->withConnectionLimit(100000)
        ->withoutHttp2Upgrade()
        ->withoutPush()
        ->withoutDebugMode()
        ->withoutRequestLogContext()
        ;

    $server = new HttpServer($sockets, new CallableRequestHandler(static function (Request $request) use (&$counter) {
        $counter += 1;

        return new Response(Status::OK, [
            'Content-Type' => 'text/plain; charset=utf-8'
        ], sprintf("Hey you are the %d hit", $counter));
    }), new NullLogger, $options);

    yield $server->start();

    Amp\Loop::onSignal(SIGINT, function (string $watcherId) use ($server) {
        Amp\Loop::cancel($watcherId);
        yield $server->stop();
    });
});