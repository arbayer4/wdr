
   
import React from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Home from "../components/Home";
import About from "../components/About"

export default (
	<Router>
		<Routes>
    <Route path="/" element={<Home />} />
    <Route path="/about" element={<About />} />
		</Routes>
	</Router>
);