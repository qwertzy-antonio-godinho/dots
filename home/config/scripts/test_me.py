#! /bin/env python3

# https://github.com/grpc/grpc/blob/master/examples/python/helloworld/async_greeter_client.py

# https://github.com/grpc/grpc/blob/master/examples/python/helloworld/greeter_client_with_options.py

# https://github.com/grpc/grpc/blob/master/examples/python/async_streaming/client.py

# https://github.com/grpc/grpc/blob/master/examples/python/data_transmission/client.py

# https://stackoverflow.com/questions/47831895/how-do-i-handle-streaming-messages-with-python-grpc 

# https://grpc.io/docs/languages/python/basics/

#https://www.youtube.com/watch?v=Naonb2XD_2Q&list=PLXs6ze70rLY9u0X6qz_91bCvsjq3Kqn_O&index=4
# https://www.youtube.com/watch?v=vBH6GRJ1REM
#https://www.youtube.com/watch?v=bNtOA1EmuKk
#https://stackoverflow.com/questions/9786102/how-do-i-parallelize-a-simple-python-loop
#   https://stackoverflow.com/questions/54668701/asyncio-gather-scheduling-order-guarantee
#https://stackoverflow.com/questions/47831895/how-do-i-handle-streaming-messages-with-python-grpc

import asyncio
import pytest
import time


async def subscribe():
    return {"status_code": 200, "response": "yo"}


async def status():
    time.sleep(3)
    return 2


async def deactivate():
    return 3


@pytest.fixture
def loop() -> asyncio.AbstractEventLoop:
    loop = asyncio.new_event_loop()
    yield loop
    loop.close()


def test_me(loop: asyncio.AbstractEventLoop):

    async def stream():
        tasks = [subscribe(), status(), deactivate()]
        result = await asyncio.gather(*tasks)
        return result

    result = loop.run_until_complete(stream())
    assert result[1] == 2
    assert result == [{"status_code": 200, "response": "yo"}, 2, 3]
