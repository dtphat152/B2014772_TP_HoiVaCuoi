import express from "express";

import { recommended } from "./model.js";

const router = express.Router();

router.get(`/api/recomentdation/:id`,recommended);

export default router;
