from fastapi import FastAPI


app = FastAPI()

##put here the actual application code
## will edit this later and add code for a useful application
@app.get("/")
def hello():
    return {"message": "Hello from cost-optimized k3s platform!"}

