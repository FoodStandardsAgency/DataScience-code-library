from azure.storage.fileshare import ShareFileClient
from io import BytesIO
import pandas as pd

connection_string = "DefaultEndpointsProtocol=https;AccountName=XXXXXX;AccountKey=XXXXXX==;EndpointSuffix=core.windows.net"
share_name = "azureshareds1"
dir_name = "uv_data_extracts"
file_name = "file_name.csv"

source_file_path = f"{dir_name}/{file_name}"

# Create a ShareFileClient from a connection string
file_client = ShareFileClient.from_connection_string(
    connection_string, share_name, source_file_path
)

print("Reading from stream ...")

# Download the file from Azure into a stream
stream = file_client.download_file()

print("Loading to pandas DataFrame object ...")

df = pd.read_csv(BytesIO(stream.readall()))

print("DONE")