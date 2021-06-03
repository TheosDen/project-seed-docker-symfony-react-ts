import React = require('react');
import ReactDOM = require('react-dom');
import './styles/index.css';
import App from "./App";

import 'bootstrap/dist/css/bootstrap.min.css';
import {Navbar} from "react-bootstrap";

ReactDOM.render(
    <React.StrictMode>
        <App />
    </React.StrictMode>,
    document.getElementById('root')
);