import pytest
from app import app  # Replace 'app' with your app.py filename


@pytest.fixture
def client():
    with app.test_client() as client:
        yield client


# Tests for the '/' route
def test_index(client):
    response = client.get("/")
    assert response.status_code == 200
    assert (
        b"Hello from the Simple Python Server!" in response.data
    )  # Assuming this is in your index.html


# Tests for the '/status' route
def test_status(client):
    response = client.get("/status")
    assert response.status_code == 200
    assert response.json == {"status": "OK", "message": "System running"}


# Tests for the '/process-data' route
def test_process_data_success(client):
    response = client.post(
        "/process-data", data={"some_input": "value"}
    )  # Example data
    assert response.status_code == 200
    assert response.json == {"result": "success"}


def test_process_data_invalid_method(client):
    response = client.get("/process-data")
    assert response.status_code == 405
    assert response.json == {"error": "Only POST requests allowed"}


# You'd likely add more tests for data validation and error
# handling within '/process-data'
