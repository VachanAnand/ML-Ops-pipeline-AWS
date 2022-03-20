import logo from './logo.svg';
import architecture from './architecture.png'
import './App.css';
import { Authenticator } from '@aws-amplify/ui-react';
import '@aws-amplify/ui-react/styles.css';
import { Storage } from "aws-amplify";

function App() {
  const handleChange = async (e) => {
      const fileContent = e.target.files[0]
      /*const fileName = e.target.files[0].name*/
      const fileType = e.target.files[0].type
      let ext = fileContent.name.split(".").pop().toLowerCase();
      let fileName =
          "data/" +
          fileContent.name.substr(0, fileContent.name.indexOf(ext) - 1) +
          "." +
          ext;
      fileName = fileName.replace(" ", "_");

      try {
          // Upload the file to s3 with private access level.
          await Storage.put(fileName, fileContent, {
              contentType: fileType,
              level: 'private',
              progressCallback(progress) {
                  console.log(`Uploaded: ${progress.loaded}/${progress.total}`);
              },
          })
      } catch (err) {
          console.log(err);
      }
  }  
  return (
    <div>
      <h1 style={{textAlign: 'center'}} >Welcome To Data Pipeline Demo</h1>
      <div style={{marginLeft:'10%'}}>
      <h3>Upload a file</h3>
        <form>
            <label>
              <input style={{margin:'30px'},{width:'50%'},{border:'1px solid black'}} type="file" onChange={(evt) => handleChange(evt)}/>
            </label>
            <input style={{margin:'30px'},{width:'60%'}} type="submit" value="Upload to S3" />
        </form>
        <hr style={{margin:'30px'}}></hr>
        <h2>Architecture Diagram</h2>
        <img style={{width: '60%'}}  src={architecture} className="architecture" alt="logo" />

      </div>

    </div>
  );

}

export default App;
