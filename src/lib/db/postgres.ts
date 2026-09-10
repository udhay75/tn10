// ============================================================================
// PostgreSQL Database Client Pool for Local Docker Container
// Connects to tn10_postgres container at localhost:5432/tn10_study
// ============================================================================

import { Pool } from 'pg';

let pool: Pool | null = null;

export function getPostgresPool(): Pool {
  if (!pool) {
    pool = new Pool({
      host: process.env.PGHOST || 'localhost',
      port: Number(process.env.PGPORT) || 5432,
      user: process.env.PGUSER || 'postgres',
      password: process.env.PGPASSWORD || 'postgres',
      database: process.env.PGDATABASE || 'tn10_study',
      max: 10,
      idleTimeoutMillis: 30000,
      connectionTimeoutMillis: 5000,
    });

    pool.on('error', (err) => {
      console.error('Unexpected error on idle PostgreSQL client:', err);
    });
  }

  return pool;
}

export async function queryPostgres(text: string, params?: any[]) {
  const p = getPostgresPool();
  return await p.query(text, params);
}
