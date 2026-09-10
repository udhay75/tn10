// ============================================================================
// MongoDB Database Client & Connection Manager
// Supports Coolify MongoDB deployments with connection caching and index setup
// ============================================================================

import { MongoClient, Db } from 'mongodb';

export function getMongoUri(): string {
  if (process.env.MONGODB_URI && process.env.MONGODB_URI.trim().length > 0) {
    return process.env.MONGODB_URI.trim();
  }
  if (process.env.MONGO_URL && process.env.MONGO_URL.trim().length > 0) {
    return process.env.MONGO_URL.trim();
  }
  if (process.env.MONGODB_URL && process.env.MONGODB_URL.trim().length > 0) {
    return process.env.MONGODB_URL.trim();
  }
  if (process.env.DATABASE_URL && (process.env.DATABASE_URL.startsWith('mongodb://') || process.env.DATABASE_URL.startsWith('mongodb+srv://'))) {
    return process.env.DATABASE_URL.trim();
  }
  return '';
}

export function isMongoConfigured(): boolean {
  return getMongoUri().length > 0;
}

const dbName = process.env.MONGODB_DB || process.env.MONGO_DB || 'tn10_study';

let client: MongoClient | null = null;
let clientPromise: Promise<MongoClient> | null = null;
let indexesInitialized = false;

declare global {
  // eslint-disable-next-line no-var
  var _mongoClientPromise: Promise<MongoClient> | undefined;
}

const clientOptions = {
  serverSelectionTimeoutMS: 5000,
  connectTimeoutMS: 5000,
  socketTimeoutMS: 15000,
  maxPoolSize: 10,
};

export async function getMongoClient(): Promise<MongoClient> {
  const uri = getMongoUri();
  if (!uri) {
    throw new Error('MongoDB connection URI is not set in environment variables (MONGODB_URI, MONGO_URL, or DATABASE_URL)');
  }

  if (process.env.NODE_ENV === 'development') {
    if (!global._mongoClientPromise) {
      client = new MongoClient(uri, clientOptions);
      global._mongoClientPromise = client.connect();
    }
    return global._mongoClientPromise;
  } else {
    if (!clientPromise) {
      client = new MongoClient(uri, clientOptions);
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
      await db.collection('users').createIndex(
        { email: 1 },
        { unique: true, sparse: true }
      );
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
