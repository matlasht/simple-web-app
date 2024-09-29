import json


def test_index_route(app, client):
    res = client.get('/')
    assert res.status_code == 200
    expected = '<h1>Hello, World!</h1>'
    assert expected in res.get_data(as_text=True)