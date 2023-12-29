using System;
using UnityEngine;

public class BasicCharacter : MonoBehaviour{
    [SerializeField] private float speed = 1f;
    [SerializeField] private float runningSpeed = 2f;

    [Header("Relations")]
    [SerializeField] private Animator animator = null;
    [SerializeField] private Rigidbody physicsBody = null;
    [SerializeField] private SpriteRenderer[] spriteRenderer = null;
    private Vector3 _movement;

    public void Update() {
      float inputY = 0;
      if (Input.GetKey(KeyCode.UpArrow) || Input.GetKey(KeyCode.W))
        inputY = 1;
      else if (Input.GetKey(KeyCode.DownArrow) || Input.GetKey(KeyCode.S))
        inputY = -1;

      // Horizontal
      float inputX = 0;
      if (Input.GetKey(KeyCode.RightArrow) || Input.GetKey(KeyCode.D)){
        inputX = 1;
        foreach(SpriteRenderer sr in spriteRenderer)
          sr.flipX = false;
      }
      else if (Input.GetKey(KeyCode.LeftArrow) || Input.GetKey(KeyCode.A)){
        inputX = -1;
        foreach(SpriteRenderer sr in spriteRenderer)
          sr.flipX = true;
      }

      // Normalize
      _movement = new Vector3(inputX, 0, inputY).normalized;

      if(inputX == 0 && inputY == 0) animator.SetBool("isWalking", false);
      else animator.SetBool("isWalking", true);
    }

    public void FixedUpdate (){
      if(Input.GetKey(KeyCode.LeftShift)) physicsBody.velocity = _movement * runningSpeed;
      else physicsBody.velocity = _movement * speed;
    }
}
