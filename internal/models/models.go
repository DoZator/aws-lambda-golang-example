package models

import "time"

type Response struct {
	Success bool      `json:"success"`
	UTC     time.Time `json:"utc"`
}

func NewResponse() *Response {
	return &Response{
		Success: true,
		UTC:     time.Now().UTC(),
	}
}
