
import express from "express";
import pkg from "pg";
const { Pool } = pkg;
import cors from "cors";

const app = express();
app.use(cors());

const pool = new Pool({
  user: "bundesheer_user",
  host: "172.30.176.226",
  database: "bundesheer_db",
  password: "45678910",
  port: 5432
});


app.get("/api/dienstgrade", async (req, res) => {
  try {
    const query = `
      SELECT json_build_object(
        'name', 'Österreichisches Bundesheer',
        'children', json_agg(
          json_build_object(
            'name', dgg.name,
            'children', (
              SELECT json_agg(
                json_build_object(
                  'name', dg.name,
                  'abkuerzung', dg.abkuerzung,
                  'nato_rang', dg.nato_rang,
                  'funktionen', (
                    SELECT json_agg(f.funktion)
                    FROM funktionen f
                    WHERE f.dienstgrad_id = dg.id
                  )
                ) ORDER BY dg.sortierung
              )
              FROM dienstgrade dg
              WHERE dg.dienstgradgruppe_id = dgg.id
            )
          ) ORDER BY dgg.sortierung
        )
      ) AS hierarchie
      FROM dienstgradgruppen dgg;
    `;

    const result = await pool.query(query);
    res.json(result.rows[0].hierarchie);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Serverfehler" });
  }
});

app.listen(3000, () => {
  console.log("Server läuft auf http://localhost:3000");
});
