-- Create appointments table to store confirmed appointment data
-- This table stores the structured appointment data captured and confirmed through the AI system

-- Create enum for appointment types (can be extended)
CREATE TYPE appointment_type_enum AS ENUM (
    'consulta_general',
    'control',
    'procedimiento',
    'cirugia',
    'terapia',
    'examen',
    'otro'
);

-- Create enum for capture methods
CREATE TYPE capture_method_enum AS ENUM (
    'audio',
    'image', 
    'text'
);

-- Create the appointments table
CREATE TABLE public.appointments (
    -- Primary identifier
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- User identification (assumes auth.users table exists)
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    
    -- Appointment details from AI capture
    doctor_name TEXT,
    specialty TEXT,
    date DATE, -- Parsed from ISO format YYYY-MM-DD
    time TIME, -- Parsed from 24-hour format HH:MM
    location TEXT,
    address TEXT,
    phone TEXT,
    appointment_type appointment_type_enum,
    instructions TEXT,
    authorization_number TEXT,
    notes TEXT,
    
    -- AI processing metadata
    confidence INTEGER CHECK (confidence >= 0 AND confidence <= 100),
    capture_method capture_method_enum NOT NULL,
    raw_text TEXT, -- Original text used for capture (transcription, image analysis, etc.)
    
    -- Appointment status
    status TEXT DEFAULT 'scheduled' CHECK (status IN ('scheduled', 'confirmed', 'cancelled', 'completed', 'missed')),
    
    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Soft delete
    deleted_at TIMESTAMPTZ
);

-- Create indexes for better query performance
CREATE INDEX idx_appointments_user_id ON appointments(user_id);
CREATE INDEX idx_appointments_date ON appointments(date);
CREATE INDEX idx_appointments_status ON appointments(status);
CREATE INDEX idx_appointments_doctor_name ON appointments(doctor_name);
CREATE INDEX idx_appointments_specialty ON appointments(specialty);
CREATE INDEX idx_appointments_deleted_at ON appointments(deleted_at);

-- Create composite index for user appointments by date
CREATE INDEX idx_appointments_user_date ON appointments(user_id, date) WHERE deleted_at IS NULL;

-- Enable Row Level Security (RLS)
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;

-- Create policy: Users can only see their own appointments
CREATE POLICY "Users can view their own appointments" ON appointments
    FOR SELECT USING (auth.uid() = user_id);

-- Create policy: Users can insert their own appointments
CREATE POLICY "Users can insert their own appointments" ON appointments
    FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Create policy: Users can update their own appointments
CREATE POLICY "Users can update their own appointments" ON appointments
    FOR UPDATE USING (auth.uid() = user_id);

-- Create policy: Users can delete their own appointments (soft delete)
CREATE POLICY "Users can delete their own appointments" ON appointments
    FOR DELETE USING (auth.uid() = user_id);

-- Create function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_appointments_updated_at 
    BEFORE UPDATE ON appointments 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Add helpful comments
COMMENT ON TABLE appointments IS 'Stores medical appointments captured and confirmed through AI processing';
COMMENT ON COLUMN appointments.confidence IS 'AI confidence score (0-100) for the captured appointment data';
COMMENT ON COLUMN appointments.capture_method IS 'Method used to capture the appointment (audio, image, text)';
COMMENT ON COLUMN appointments.raw_text IS 'Original text from transcription or image analysis used for AI processing';
COMMENT ON COLUMN appointments.status IS 'Current status of the appointment';
COMMENT ON COLUMN appointments.deleted_at IS 'Soft delete timestamp - NULL means active';
