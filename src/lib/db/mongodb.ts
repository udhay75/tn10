// ============================================================================
// MongoDB Database Client & Connection Manager
// Supports Coolify MongoDB deployments with connection caching and index setup
// ============================================================================

import { MongoClient, Db } from 'mongodb';

const uri = process.env.MONGODB_URI || '';
const dbName = process.env.MONGODB_DB || 'tn10_study';

let client: MongoClient | null = null;
let clientPromise: Promise<MongoClient> | null = null;
let indexesInitialized = false;

declare global {
  // eslint-disable-next-line no-var
  var _mongoClientPromise: Promise<MongoClient> | undefined;
}

export function isMongoConfigured(): boolean {
  return Boolean(process.env.MONGODB_URI && process.env.MONGODB_URI.trim().length > 0);
}

export async function getMongoClient(): Promise<MongoClient> {
  if (!isMongoConfigured()) {
    throw new Error('MONGODB_URI is not set in environment variables');
  }

  if (process.env.NODE_ENV === 'development') {
    // In development mode, use a global variable so that the value
    // is preserved across module reloads caused by HMR (Hot Module Replacement).
    if (!global._mongoClientPromise) {
      client = new MongoClient(uri);
      global._mongoClientPromise = client.connect();
    }
    return global._mongoClientPromise;
  } else {
    // In production mode, it's best to not use a global variable.
    if (!clientPromise) {
      client = new MongoClient(uri);
      clientPromise = client.connect();
    }
    return clientPromise;
  }
}

export async function getMongoDb(): Promise<Db> {
  const mClient = await getMongoClient();
  const db = mClient.db(dbName);

  // Initialize indexes once
  if (!indexesInitialized) {
    try {
      await db.collection('student_item_progress').createIndex(
        { student_id: 1, item_code: 1 },
        { unique: true }
      );
      await db.collection('revision_history').createIndex(
        { student_id: 1, item_code: 1, revision_date: -1 }
      );
      indexesInitialized = true;
    } catch (err) {
      console.warn('MongoDB index initialization note:', err);
    }
  }

  return db;
}
