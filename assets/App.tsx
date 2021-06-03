import React = require("react");
import {Col, Container, Navbar, Row} from "react-bootstrap";
import {BrowserRouter as Router, Link, Route, Switch} from "react-router-dom";
import HomePage from "./controllers/HomePage";
import LoginPage from "./controllers/LoginPage";

export default function App() {
    return <>
        <Router>
            <Container>
                <Row>
                    <Col>
                        <Navbar bg="dark" variant="dark">
                            <Navbar.Brand><Navbar.Text><Link to="/">Home</Link></Navbar.Text></Navbar.Brand>
                            <Navbar.Collapse className="justify-content-end">
                                <Navbar.Text>
                                    <Link to="/login">Login</Link>
                                </Navbar.Text>
                            </Navbar.Collapse>
                        </Navbar>
                    </Col>
                </Row>

                <Switch>
                    <Route exact path="/">
                        <HomePage/>
                    </Route>
                    <Route path="/login">
                        <LoginPage/>
                    </Route>
                </Switch>
            </Container>
        </Router>
    </>;
}